convert -fuzz 6% -delay 4 -loop 0 -layers OptimizePlus frames/*.png tmp.gif

::gifsicle -O3 --colors 50 tmp.gif > output.gif