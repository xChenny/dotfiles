nmap <localleader>tf :TestFile<CR>
nmap <localleader>tn :TestNearest<CR>
nmap <localleader>tl :TestLast<CR>
nmap <localleader>ts :TestSuite<CR>

let test#go#gotest#options = '-exec="env LD_LIBRARY_PATH=/Users/andrew.chen/Code/mongodb/baas/etc/dylib/lib" -v -tags debug'




