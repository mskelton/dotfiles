Phoenix.set({
  daemon: true,
  openAtLogin: true,
})

const handler = new Key("k", ["cmd", "option"], () => {
  Window.focused().setTopLeft({ x: 100, y: 10 })
})
