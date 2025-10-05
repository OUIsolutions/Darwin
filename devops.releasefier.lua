local cachify = load_global_module("cachify")


function main()
  os.execute("git restore .")

  cachify.register_first({
      sources = {"darwindeps.json"},
      cache_name="darwindeps",
      cache_dir=".cachify"
  })

  cachify.register_first({
      sources = {"src","dependencies","assets","darwinconf.lua","builds"},
      cache_name="release",
      cache_dir=".cachify"
  })


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
      cache_name="darwindeps",
      cache_dir=".cachify",
      ignore_first = true
  })  


end 
main()