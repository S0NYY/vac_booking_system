import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [ "country", "cities", "districts" ]

  connect() {
    console.log("hello")
  }

  fetchCities()
  {
    Rails.ajax(
      {
        type: "GET",
        url: "/admin/countries/fetch_cities",
        data: "country_id=" + this.countryTarget.value,
        success: (data) =>{
          this.citiesTarget.innerHTML = data.body.innerHTML
        }
      }
    )
  }

  fetchDistricts()
  { 
    Rails.ajax(
      {
        type: "GET",
        url: "/admin/cities/fetch_districts",
        data: "city_id=" + this.citiesTarget.value,
        success: (data) =>{
          this.districtsTarget.innerHTML = data.body.innerHTML
        }
      }
    )
  }
}
