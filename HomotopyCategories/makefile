.PHONY: test

install:
	julia -e 'using Pkg; Pkg.develop(path=".");'

uninstall:
	julia -e 'using Pkg; Pkg.rm("HomotopyCategories");'

test:
	julia -e 'using Pkg; Pkg.test("HomotopyCategories");'

gen:
	rm -f ./src/gap/*.autogen.jl
	rm -f ./src/gap/*/*.autogen.jl
	rm -f ./docs/src/*.autogen.md
	./.generate.sh -e gen_full=0

gen-full:
	rm -f ./src/gap/*.autogen.jl
	rm -f ./src/gap/*/*.autogen.jl
	rm -f ./docs/src/*.autogen.md
	./.generate.sh -e gen_full=1

git-commit:
	@if git diff Project.toml | grep -q '^+version ='; then \
	echo -e "\033[32mCommitting changes in \"HomotopyCategories\"\033[0m"; \
	git add .; \
	git commit \
		-m "Update to GAP's $$(grep "# Transpiled from GAP's" "Project.toml" | cut -d ' ' -f 5-)" \
		-m "Bump Version to v$$(grep "version = " "Project.toml" | cut -d '"' -f 2)" \
		; \
	else \
		echo -e "\033[33mNo changes in \"HomotopyCategories\" to commit or no version bump detected.\033[0m"; \
	fi

codecov:
	julia --project=. -e 'using Coverage; using Pkg; Pkg.test(coverage=true); LCOV.writefile("coverage.lcov", process_folder(pwd()));'
	genhtml -o coverage_report coverage.lcov
	open coverage_report/index.html

JULIA_KERNEL := julia-$(shell julia -e 'v=VERSION; print(v.major,".",v.minor)')
NOTEBOOKS_DIR := notebooks

execute-notebooks:
	@if [ -d "$(NOTEBOOKS_DIR)" ]; then \
		cd $(NOTEBOOKS_DIR) && \
		for nb in *.ipynb; do \
			[ -f "$$nb" ] || continue; \
			echo "Executing $$nb ..."; \
			jupyter nbconvert \
				--ExecutePreprocessor.kernel_name=$(JULIA_KERNEL) \
				--ExecutePreprocessor.timeout=-1 \
				--ExecutePreprocessor.record_timing=False \
				--to notebook --execute "$$nb" --inplace || exit 1; \
		done; \
	fi

test-notebooks:
	@if [ -d "$(NOTEBOOKS_DIR)" ]; then \
		cd $(NOTEBOOKS_DIR) && \
		for nb in *.ipynb; do \
			[ -f "$$nb" ] || continue; \
			echo "Testing $$nb ..."; \
			jupyter nbconvert \
				--ExecutePreprocessor.kernel_name=$(JULIA_KERNEL) \
				--ExecutePreprocessor.timeout=-1 \
				--ExecutePreprocessor.record_timing=False \
				--to notebook --execute "$$nb" --output out || exit 1; \
			mv out.ipynb out; \
			cat "$$nb" | grep -v '"version": "' \
				| perl -0777 -pe 's/,\n(\s*\])/\n$$1/g' \
				| perl -0777 -pe 's/,?\n[ \t]*\{[^{}]*"output_type":\s*"stream"[^{}]*\}//g' \
				| perl -0777 -pe 's/\[\s*\]/[]/g' \
				> modified_in; \
			cat out | grep -v '"version": "' \
				| perl -0777 -pe 's/,\n(\s*\])/\n$$1/g' \
				| perl -0777 -pe 's/,?\n[ \t]*\{[^{}]*"output_type":\s*"stream"[^{}]*\}//g' \
				| perl -0777 -pe 's/\[\s*\]/[]/g' \
				> modified_out; \
			diff modified_in modified_out || exit 1; \
			rm modified_in modified_out out; \
		done; \
	fi


clean-codecov:
	find . -type f -name "*.jl.*.cov" -exec rm -f {} +
	rm -f coverage.lcov
	rm -rf coverage_report
