function Install_all_dependencies()
    local downloader = require("build.downloader")
    downloader.install_dependencies("darwindeps.json")
end