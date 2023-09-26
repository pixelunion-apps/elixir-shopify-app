// JS specific to LiveView in ShopAdmin

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import {ShopifyToastHook} from "./hooks"

let Hooks = { ShopifyToastHook }
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", _info => shopify.loading(true))
window.addEventListener("phx:page-loading-stop", _info => shopify.loading(false))

window.addEventListener("phx:page-loading-stop", info => {
  /*
    When navigating, AppBridge detects changes within a LiveView,
    however, it does not detect between LiveView navigation, even when it is
    correctly patching within a live_session. This re-emits a navigation event
    that AppBridge will detect.
  */
  destination = new URL(info.detail.to).pathname
  if (info.detail.kind == "initial" && destination != window.location.pathname) {
    history.pushState(null, '', destination);
  } else {
    history.replaceState(null, '', destination);
  }
})

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket
