import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["contacts", "template"];

  add_fields(event) {
    event.preventDefault();
    
    const template = this.templateTarget.content.cloneNode(true);
    const newIndex = new Date().getTime();

    template.querySelectorAll('input, select').forEach((field) => {
      field.name = field.name.replace('NEW RECORD', newIndex)
    });

    this.contactsTarget.appendChild(template);
  }

  remove_fields(event) {
    event.preventDefault();
    event.target.closest('.nested-fields').remove();
  }
}
