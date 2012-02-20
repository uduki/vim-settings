" qqmake qmake makeを自動で行います。

:function Build()
	:!qqmake
	:!qmake
	:!make
:endfunction

:command Build :call Build()

