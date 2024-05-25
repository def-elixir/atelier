# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Atelier.Repo.insert!(%Atelier.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Atelier.Repo
alias Atelier.Items.ItemType
# alias Atelier.Archive.Directory

# directories = [
#   %Directory{
#     id: 1,
#     name: "サンプルディレクトリ",
#   },
# ]

# Enum.each(directories, fn(directory) ->
#   Repo.insert!(directory)
# end)

# texts = [
#   %Text{
#     id: 1,
#     name: "サンプルテキスト",
#     contents: "サンプル/サンプル/サンプル",
#     directory_id: 1,
#   },
# ]

# Enum.each(texts, fn(text) ->
#   Repo.insert!(text)
# end)
