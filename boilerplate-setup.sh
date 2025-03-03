#!/usr/bin/env sh

# Borrowed a lot from https://github.com/mirego/elixir-boilerplate

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

pascalCaseBefore="ShopifyApp"
snakeCaseBefore="shopify_app"
kebabCaseBefore="shopify-app"

# The identifiers above will be replaced in the content of the files found below
content=$(find . -type f \( \
  -name "*.ex" -or \
  -name "*.exs" -or \
  -name "*.ees" -or \
  -name "*.heex" -or \
  -name "*.sh" -or \
  -name "*.json" -or \
  -name "*.js" -or \
  -name "*.yml" -or \
  -name "*.md" -or \
  -name ".envrc" \
  -name "Dockerfile" \
\) \
  -and ! -path "./boilerplate-setup.sh" \
  -and ! -path "./assets/node_modules/*" \
  -and ! -path "./_build/*" \
  -and ! -path "./deps/*" \
)

# The identifiers above will be replaced in the path of the files and directories found here
paths=$(find . -depth 2 \( \
  -path "./lib/${snakeCaseBefore}*" -or \
  -path "./lib/${snakeCaseBefore}_*" -or \
  -path "./lib/${snakeCaseBefore}.*" -or \
  -path "./test/${snakeCaseBefore}" -or \
  -path "./test/${snakeCaseBefore}_*" \
\))

# -----------------------------------------------------------------------------
# Validation
# -----------------------------------------------------------------------------

if [[ -z "$1" ]] ; then
  echo 'You must specify your project name in PascalCase as first argument.'
  exit 0
fi

pascalCaseAfter=$1
snakeCaseAfter=$(echo $pascalCaseAfter | /usr/bin/sed 's/\(.\)\([A-Z]\)/\1_\2/g' | tr '[:upper:]' '[:lower:]')
kebabCaseAfter=$(echo $snakeCaseAfter | tr '_' '-')

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------

header() {
  echo "\033[0;33m▶ $1\033[0m"
}

success() {
  echo "\033[0;32m▶ $1\033[0m"
}

run() {
  echo ${@}
  eval "${@}"
}

# -----------------------------------------------------------------------------
# Execution
# -----------------------------------------------------------------------------

header "Configuration"
echo "${pascalCaseBefore} → ${pascalCaseAfter}"
echo "${snakeCaseBefore} → ${snakeCaseAfter}"
echo "${kebabCaseBefore} → ${kebabCaseAfter}"
echo ""

header "Replacing boilerplate identifiers in content"
for file in $content; do
  run /usr/bin/sed -i "''" "s/$snakeCaseBefore/$snakeCaseAfter/g" $file
  run /usr/bin/sed -i "''" "s/$kebabCaseBefore/$kebabCaseAfter/g" $file
  run /usr/bin/sed -i "''" "s/$pascalCaseBefore/$pascalCaseAfter/g" $file
done
success "Done!\n"

header "Replacing boilerplate identifiers in file and directory paths"
for path in $paths; do
  run mv $path $(echo $path | /usr/bin/sed "s/$snakeCaseBefore/$snakeCaseAfter/g" | /usr/bin/sed "s/$kebabCaseBefore/$kebabCaseAfter/g" | /usr/bin/sed "s/$pascalCaseBefore/$pascalCaseAfter/g")
done
success "Done!\n"

header "Updating Shopify initializers"
run /usr/bin/sed -i "''" "s/$snakeCaseBefore/$snakeCaseAfter/g" lib/$snakeCaseAfter/shopify_api/initializer.ex
success "Done!\n"

header "Importing project README.md"
run "rm README.md && mv BOILERPLATE_README.md README.md"
success "Done!\n"

header "Removing boilerplate license → https://choosealicense.com"
run rm LICENSE.md
success "Done!\n"

header "Removing boilerplate code of conduct and contribution information → https://help.github.com/articles/setting-guidelines-for-repository-contributors/"
run rm CODE_OF_CONDUCT.md CONTRIBUTING.md
success "Done!\n"

header "Removing boilerplate setup script"
run rm boilerplate-setup.sh
success "Done!\n"
