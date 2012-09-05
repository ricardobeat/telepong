# Find `requestAnimationFrame` or fallback.
window.requestAnimationFrame = (
    window.requestAnimationFrame or
    window.mozRequestAnimationFrame or
    window.webkitRequestAnimationFrame or
    window.msRequestAnimationFrame or
    window.oRequestAnimationFrame or
    (fn) -> setTimeout(fn, 1000/60)
)