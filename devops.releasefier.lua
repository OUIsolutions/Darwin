local cachify = load_global_module("cachify")

os.execute("git restore .")
os.execute("git pull")

cachify.execute_config({
    sources = {"darwindeps.json"},
    callback = function() os.execute("darwin update darwindepos.json") end,
    cache_name="teste",
    cache_dir=".cachify",
    ignore_first = true
})
