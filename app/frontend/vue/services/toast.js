import Toast from "vue-toastification"
import "vue-toastification/dist/index.css"

const toastOptions = {
  position: "top-right",
  timeout: 5000,
  closeOnClick: true,
  pauseOnFocusLoss: true,
  pauseOnHover: true,
  draggable: true,
  draggablePercent: 0.6,
  showCloseButtonOnHover: false,
  hideProgressBar: false,
  closeButton: "button",
  icon: true,
  rtl: false,
  toastClassName: "custom-toast-style",
  maxToasts: 3,
  transition: "Vue-Toastification__fade",
}

export function addToast(app) {
  app.use(Toast, toastOptions)
}
