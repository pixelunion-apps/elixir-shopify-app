// JS specific to LiveView in ShopAdmin

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import {ShopifyToastHook} from "./hooks"

async function fetchMountHtml(host, route, sessionToken) {
  const url = `https://${host}/${route}`
  const response =
    await fetch(url,
      {
       method: "GET",
       headers: {
         "Content-Type": "text/html",
         "authorization": "Bearer " + sessionToken
       }
      }
    );
  return response.text();
}

function liveViewConnect(host, sessionToken) {
  let Hooks = { ShopifyToastHook }
  let socketUrl = `wss://${host}/shop_admin_live`

  let liveSocket = window.liveSocket || new LiveSocket(socketUrl, Socket, {hooks: Hooks, params: {}, bindingPrefix: "data-phx-"})

  // Show progress bar on live navigation and form submits
  window.addEventListener("phx:page-loading-start", _info => shopify.loading(true))
  window.addEventListener("phx:page-loading-stop", _info => shopify.loading(false))

  // connect if there are any LiveViews on the page
  liveSocket.connect()

  // expose liveSocket on window for web console debug logs and latency simulation:
  // >> liveSocket.enableDebug()
  // >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
  // >> liveSocket.disableLatencySim()
  window.liveSocket = liveSocket
}

function unload() {
  window.liveSocket.unload()
}


window.liveViewCommands = { fetchMountHtml, liveViewConnect, unload }
