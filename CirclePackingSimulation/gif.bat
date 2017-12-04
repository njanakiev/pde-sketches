::convert -fuzz 1 -delay 4 -loop 0 -layers OptimizePlus frames/*.png tmp.gif

convert -delay 2 -loop 0 frames/*.png tmp.gif

gifsicle -O3 --colors 10 tmp.gif > output.gif