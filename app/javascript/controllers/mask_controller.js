import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.applyMasks();
    this.setupDynamicContactMask();
    this.applyInitialContactMask();
    this.observeDOMChanges();  // Observa mudanças no DOM
  }

  applyMasks() {
    const fields = {
      cpf: document.querySelector("#applicant_document"),
      cep: document.querySelector("#applicant_zip_code"),
      salary: document.querySelector("#applicant_salary"),
    };

    // Máscara de CPF
    fields.cpf?.addEventListener("input", () => {
      let value = fields.cpf.value.replace(/\D/g, "");
      value = value.slice(0, 11);
      value = value.replace(/(\d{3})(\d)/, "$1.$2");
      value = value.replace(/(\d{3})(\d)/, "$1.$2");
      value = value.replace(/(\d{3})(\d{1,2})$/, "$1-$2");
      fields.cpf.value = value;
    });

    // Máscara de CEP
    fields.cep?.addEventListener("input", () => {
      let value = fields.cep.value.replace(/\D/g, "");
      value = value.slice(0, 8);
      value = value.replace(/^(\d{5})(\d)/, "$1-$2");
      fields.cep.value = value;
    });

    // Máscara de Salário
    fields.salary?.addEventListener("input", (e) => {
      let value = e.target.value.replace(/\D/g, "");
      if (value.length === 0) {
        e.target.value = "";
        return;
      }
      let formatted = (parseFloat(value) / 100).toLocaleString("pt-BR", {
        minimumFractionDigits: 2,
      });

      e.target.value = `R$ ${formatted}`;
    });
  }

  // Aplica máscara dinamicamente com base na seleção do tipo de contato
  setupDynamicContactMask() {
    document.querySelectorAll("[name*='contact_type']").forEach((select) => {
      this.bindSelectEvent(select);  // Vincula evento inicial
    });
  }

  // Aplica máscara no carregamento inicial
  applyInitialContactMask() {
    document.querySelectorAll("[name*='contact_type']").forEach((select) => {
      const selectedType = select.value;
      const field = select.closest(".nested-fields").querySelector(".contact-value");
      this.updateMask(selectedType, field);
    });
  }

  // Observa mudanças no DOM e aplica máscara a campos adicionados dinamicamente
  observeDOMChanges() {
    const observer = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        mutation.addedNodes.forEach((node) => {
          if (node.nodeType === 1 && node.matches(".nested-fields")) {
            const select = node.querySelector("[name*='contact_type']");
            const field = node.querySelector(".contact-value");

            // Aplica máscara ao novo campo
            this.updateMask(select.value, field);
            this.bindSelectEvent(select);

            // Força a aplicação imediata da máscara
            field.dispatchEvent(new Event("input"));
          }
        });
      });
    });

    observer.observe(document.querySelector("#contacts"), {
      childList: true,
      subtree: true,
    });
  }

  // Aplica a máscara com base no tipo de contato
  updateMask(selectedType, field) {
    if (!field) return;

    // Limpa formatação anterior
    field.value = field.value.replace(/\D/g, "");
    field.removeEventListener("input", field.phoneMaskHandler);

    switch (selectedType) {
      case "residential":
      case "commercial":
        this.applyPhoneMask(field, 10);  // Formato: (99) 9999-9999
        break;
      case "mobile":
      case "whatsapp":
        this.applyPhoneMask(field, 11);  // Formato: (99) 99999-9999
        break;
      case "email":
        this.removeMask(field);
        break;
      default:
        this.removeMask(field);
        break;
    }
  }

  applyPhoneMask(field, maxDigits) {
    const phoneMaskHandler = () => {
      let value = field.value.replace(/\D/g, "");
      value = value.slice(0, maxDigits);

      value = value.replace(/^(\d{2})(\d)/g, "($1) $2");
      if (maxDigits === 11) {
        value = value.replace(/(\d{5})(\d{4})$/, "$1-$2");
      } else {
        value = value.replace(/(\d{4})(\d{4})$/, "$1-$2");
      }

      field.value = value;
    };

    field.addEventListener("input", phoneMaskHandler);
    field.phoneMaskHandler = phoneMaskHandler;
    field.dispatchEvent(new Event("input"));
  }

  removeMask(field) {
    field.value = "";
    field.placeholder = "Digite o email";
    field.removeEventListener("input", field.phoneMaskHandler);
  }

  // Vincula o evento de seleção novamente ao campo recém-adicionado
  bindSelectEvent(select) {
    select.addEventListener("change", (event) => {
      const selectedType = event.target.value;
      const field = event.target.closest(".nested-fields").querySelector(".contact-value");
      this.updateMask(selectedType, field);

      // Reaplica imediatamente a máscara após a mudança
      field.dispatchEvent(new Event("input"));
    });
  }
}
