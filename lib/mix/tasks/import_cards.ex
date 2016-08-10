defmodule Mix.Tasks.ImportCards do
  use Mix.Task

  @shortdoc "Imports cards from DeckBrew API"

  def run(_args) do
    Mix.shell.info "Importing Cards..."
    DeckBuilder.CardImporter.import
    Mix.shell.info "Finished Importing!"
  end
end
