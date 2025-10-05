local cachify = load_global_module("cachify")

os.execute("git restore .")
os.execute("git pull")

os.execute("darwin update darwindeps.json")

cachify.execute_config({
    sources = {"darwindeps.json"},
    callback = function()
        dtw.remove_any("dependencies")
        os.execute("darwin install darwindeps.json")
        os.execute("git add .")
        os.execute("git commit -m 'deps: update dependencies'")
      end,
    cache_name="teste",
    cache_dir=".cachify",
    ignore_first = true
})
