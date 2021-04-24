import Dog
import System.Process
main = do 
    r <- createProcess (proc "ls" [])
    print $ dog "dog"
    print "Hello"