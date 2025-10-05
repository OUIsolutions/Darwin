os.execute("git restore .")
os.execute("git pull")



if true then return end 
cachify.execute_config({
    sources = {"darwindeps.json"},
    callback = function() print("Callback executed!") end,
    cache_name="teste",
    cache_dir=".cachify",
    ignore_first = true
})
