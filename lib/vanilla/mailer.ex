defmodule Vanilla.Mailer do
  use Bamboo.Mailer, otp_app: :vanilla
  require Logger

  def send(email) do
    try do
      deliver_now(email)
      log :info, "Sent #{describe_email(email)}"
      {:ok}
    catch e ->
      # SMTP failures may raise ErlangErrors which need to be caught rather than rescued (?)
      log :warn, "Error sending email #{describe_email(email)}: #{inspect(e)}"
      {:error, e}
    end
  end

  defp describe_email(email) do
    module = "#{email.private.view_module}" |> String.split(".") |> List.last()
    template = email.private.view_template |> String.split(".") |> List.first()
    to = inspect(email.to)
    "to: #{to}, template: #{module}.#{template}, subject: \"#{email.subject}\")"
  end

  defp log(level, msg), do: Logger.log(level, "Vanilla.Mailer: #{msg}")
end
