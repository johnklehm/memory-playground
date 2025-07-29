setup.sysdeps:
	@-asdf plugin-add python; asdf install python
	@asdf plugin update --all \
      && for p in $$(cut -d" " -f1 .tool-versions | sort | tr '\n' ' '); do \
           asdf plugin add $$p || true; \
         done \
      && asdf install || echo "WARNING: Failed to install sysdeps. Environment may disagree with .tool-versions"
	asdf install
setup:
	zig build --summary all

run: setup
	./zig-out/bin/memory-playground
