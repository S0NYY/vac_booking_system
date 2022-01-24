import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
    static targets = [
	    "country",
	    "city",
	    "district",
	    "bu_unit",
	    "slots"
    ]

    connect() {
        console.log('Hello, Stumulus')
    }

    fetchCities() {
        Rails.ajax({
            type: "GET",
            url: "/slots/fetch_cities",
            data: "country_id=" + this.countryTarget.value,
            success: (data) => {
                this.cityTarget.innerHTML = data.body.innerHTML
            }
        });
    }

    fetchDistricts() {
        Rails.ajax({
            type: "GET",
            url: "/slots/fetch_districts",
            data: "city_id=" + this.cityTarget.value,
            success: (data) => {
                this.districtTarget.innerHTML = data.body.innerHTML
            }
        });
    }

    fetchBusinessUnits() {
        Rails.ajax({
            type: "GET",
            url: "/slots/fetch_business_units",
            data: "country_id=" + this.countryTarget.value + "&city_id=" + this.cityTarget.value + "&district_id=" + this.districtTarget.value,
            success: (data) => {
                this.bu_unitTarget.innerHTML = data.body.innerHTML
            }
        });
    }

    fetchSlots() {
        Rails.ajax({
            type: "GET",
            url: "/slots/",
            data: "business_unit_id=" + this.bu_unitTarget.value,
            success: (data) => {
                this.slotsTarget.innerHTML = data.body.innerHTML
            }
        });
    }
    selectSlot() {
        Array.from(document.querySelectorAll('.slot-item')).forEach(function(el) {
            if(el !== event.target) {
                el.classList.remove('btn-warning');
                document.querySelector('input.step1_submit').classList.add('invisible')
            }
        });
 
        event.target.classList.toggle("btn-warning")
        document.querySelector('input#order_order_date').value = event.params['slotTime']
        document.querySelector('input#order_business_unit_slot_id').value = event.params['slotId']
 
        if(event.target.classList.contains('btn-warning')) {
            document.querySelector('input.step1_submit').classList.remove('invisible')
        }
    }
}