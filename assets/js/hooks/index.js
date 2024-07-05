/*
Handles the integration between flash to a Shopify AppBridge Toast

See ShopAdminComponents.toast
*/
export const ShopifyToastHook = {
  mounted() {
    shopify.toast.show(this.el.dataset.message, {
      onDismiss: () => {
        this.pushEvent("lv:clear-flash", {value: {key: this.el.dataset.kind}})
      },
      isError: this.el.dataset.kind == 'error'
    });
  }
}
