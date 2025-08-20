
function local_build()
    amalgamation_build()
    local comand = [[gcc release/amalgamation.c    -o darwin]]
    os.execute(comand)
   
end