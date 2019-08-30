defmodule AdoptAFamilyWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias AdoptAFamilyWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint AdoptAFamilyWeb.Endpoint

      def session_conn() do
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(AdoptAFamily.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(AdoptAFamily.Repo, {:shared, self()})
    end

    {:ok, user} = AdoptAFamily.Accounts.create_user(%{
      email: "staged@email.com",
      username: "staged_username",
      name: "staged name",
      password: "password",
      password_confirmation: "password"
    })

    opts =
      Plug.Session.init(
        store: :cookie,
        key: "foobar",
        encryption_salt: "encrypted cookie salt",
        signing_salt: "signing salt",
        log: false,
        encrypt: false
      )
    session_conn = Phoenix.ConnTest.build_conn()
                |> Plug.Session.call(opts)
                |> Plug.Conn.fetch_session()

    auth_conn = Phoenix.ConnTest.build_conn()
                |> Plug.Test.init_test_session(current_user_id: user.id)

    {:ok, %{
      conn: Phoenix.ConnTest.build_conn(),
      session_conn: session_conn,
      auth_conn: auth_conn,
      staged_user: user
    }}
  end
end
