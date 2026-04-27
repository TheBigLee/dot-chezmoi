vim.filetype.add({
  extension = {
    gotmpl = "gotmpl",
    tmpl = "gotmpl",
    libsonnet = "libsonnet",
    mdx = "markdown.mdx",
  },
  filename = {
    [".gitlab-ci.yml"] = "yaml.gitlab",
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
  },
  pattern = {
    ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
    [".*/templates/.*%.ya?ml"] = "yaml.helm-values",
    ["values.*%.ya?ml"] = "yaml.helm-values",
    [".*%.gitlab%-ci.*%.ya?ml"] = "yaml.gitlab",
  },
})
