local cachify = load_global_module("cachify")

os.execute("git restore .")
os.execute("git pull")
os.execute("darwin update darwindepos.json")


cachify.execute_config({
    sources = {"darwindeps.json"},
    callback = function()   end,
    cache_name="teste",
    cache_dir=".cachify",
    ignore_first = true
})
