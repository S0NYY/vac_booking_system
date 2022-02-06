module Slots
  # ...
  class SqlService
    def initialize(bu_unit)
      @bu_unit = bu_unit
    end

    def slots
      result = BusinessUnitSlot.select('bus.id, bus.duration, bus.start_date::date AS current_start_date, slots.item AS slot_item')
        .from(@bu_unit, 'bus')
        .joins(
          "LEFT JOIN LATERAL (
            SELECT generate_series(bus.start_date, bus.end_date, bus.duration * '1 minutes'::interval)::timestamp as item
          ) slots ON true"
        )
        .joins(
          'LEFT JOIN orders o ON o.business_unit_slot_id = bus.id
            AND o.finished = true AND o.order_date::timestamp = slots.item'
        )
        .where('o.id IS NULL')
        .where('slots.item >= ?', Time.current)
        .order(:start_date)
      result
    end
  end
end
