# ...
class OrderCancellationPresenter < Struct.new(:order)
  def business_unit
    order.business_unit_slot&.business_unit&.name
  end

  def address
    "#{order.business_unit_slot.business_unit.country.name},
     #{order.business_unit_slot.business_unit.city.name},
     #{order.business_unit_slot.business_unit.district.name}"
  end

  def order_time
    order.order_date
  end

  def order_id
    order.id
  end
end
