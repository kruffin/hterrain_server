## Purpose
Illustrate an issue with the heightmap plugin (https://github.com/Zylann/godot_heightmap_plugin) when using the Godot server executable.

## Running
Easy way is with docker and docker-compose.

    docker-compose build
    docker-compose up

## Result
This will produce the following log output:

```
Recreating hterrain_server_terrain-server_1 ... done
Attaching to hterrain_server_terrain-server_1
terrain-server_1  | ERROR: Failed loading resource: res://texture_data/HterrainServer_slot0_albedo_bump.packed_tex. Make sure resources have been imported by opening the project in the editor at least once.
terrain-server_1  |    at: _load (core/io/resource_loader.cpp:270)
terrain-server_1  | ERROR: res://HterrainServer.tscn:6 - Parse Error: [ext_resource] referenced nonexistent resource at: res://texture_data/HterrainServer_slot0_albedo_bump.packed_tex
terrain-server_1  |    at: poll (scene/resources/resource_format_text.cpp:412)
terrain-server_1  | ERROR: Failed to load resource 'res://HterrainServer.tscn'.
terrain-server_1  |    at: load (core/io/resource_loader.cpp:206)
terrain-server_1  | ERROR: Failed loading resource: res://HterrainServer.tscn. Make sure resources have been imported by opening the project in the editor at least once.
terrain-server_1  |    at: _load (core/io/resource_loader.cpp:270)
terrain-server_1  | ERROR: Failed loading scene: res://HterrainServer.tscn
terrain-server_1  |    at: start (main/main.cpp:2011)
terrain-server_1  | WARNING: ObjectDB instances leaked at exit (run with --verbose for details).
terrain-server_1  |      at: cleanup (core/object.cpp:2064)
terrain-server_1  | ERROR: Resources still in use at exit (run with --verbose for details).
terrain-server_1  |    at: clear (core/resource.cpp:417)
terrain-server_1  | ERROR: There are still MemoryPool allocs in use at exit!
terrain-server_1  |    at: cleanup (core/pool_vector.cpp:63)
terrain-server_1  | Godot Engine v3.4.2.stable.mono.official.45eaa2daf - https://godotengine.org
terrain-server_1  |  
terrain-server_1  | Mono: Log file is: '/root/.local/share/godot/app_userdata/hterrain_server/mono/mono_logs/2022-01-18_22.42.46_1.log'
hterrain_server_terrain-server_1 exited with code 0
```

For some reason it can't load the packed_tex files when run with the server executable.