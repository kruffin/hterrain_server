FROM debian:stable-slim AS base

ARG GODOT_VERSION=3.4.2

RUN apt update && apt install -y --no-install-recommends \
	ca-certificates \
	wget \
	unzip \
	scons

RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/mono/Godot_v${GODOT_VERSION}-stable_mono_linux_headless_64.zip
RUN unzip Godot_v${GODOT_VERSION}-stable_mono_linux_headless_64.zip
RUN ln -s /Godot_v${GODOT_VERSION}-stable_mono_linux_headless_64/Godot_v${GODOT_VERSION}-stable_mono_linux_headless.64 /usr/local/bin/godot-headless

RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/mono/Godot_v${GODOT_VERSION}-stable_mono_linux_server_64.zip

RUN unzip Godot_v${GODOT_VERSION}-stable_mono_linux_server_64.zip
RUN ln -s /Godot_v${GODOT_VERSION}-stable_mono_linux_server_64/Godot_v${GODOT_VERSION}-stable_mono_linux_server.64 /usr/local/bin/godot

WORKDIR /app
COPY godot_files .
#WORKDIR /app/godot_files/addon_src/godot_heightmap_plugin/addons/zylann.hterrain/native/godot_cpp
#RUN scons platform=linux generate_bindings=yes target=release
#WORKDIR /app/godot_files/addon_src/godot_heightmap_plugin/addons/zylann.hterrain/native
#RUN scons platform=linux target=release

#WORKDIR /app
#RUN rm -rf /app/godot_files/addons/zylann.hterrain
#RUN cp -r /app/godot_files/addon_src/godot_heightmap_plugin/addons/zylann.hterrain /app/godot_files/addons/.

RUN godot-headless --path . --export-pack "Linux_Server" ./.builds/hterrain_server.pck
CMD ["godot", "--main-pack", "/app/godot_files/.builds/hterrain_server.pck"]
