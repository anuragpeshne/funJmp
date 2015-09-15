# funJmp
A light way to jump to function definition in Vim without generating ctags.
It uses regular expression to search for function definition in all open buffers. That means you will need to keep the file open in one of the buffers in which you expect the function definition to be.

### How to use:
* Go to any of the occurrence of the function name, place cursor on it.
* Press ∂: that it `option + d` on mac. You can configure this shortcut at [repo/plugin/funJump.vim line 40](https://github.com/anuragpeshne/funJmp/blob/master/plugin/funJmp.vim#L40)

### To-Do/Current Limitations:
* It fails horribly, and puts cursor at beginning of the last buffer. Correct this.
* Currently supports (I can add more if you are interested in using this):
  *  C
  *  Java
  *  Python
  *  PHP
  *  JavaScript
* Get better keyboard shortcut. 
  
