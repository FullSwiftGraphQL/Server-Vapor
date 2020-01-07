import App

/*
 If Xcode crashes, it can sometimes leave the connection open. Use this command to to force quit
 the local process using port 8080:
 
 .kill $(lsof -t -i:8080)
 */

try app(.detect()).run()
