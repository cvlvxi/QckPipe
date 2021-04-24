import System.Process
main = do 
    r <- createProcess (proc "ls" [])
    print "Hello"