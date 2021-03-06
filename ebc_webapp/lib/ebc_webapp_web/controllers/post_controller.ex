defmodule EbcWebappWeb.PostController do
  use EbcWebappWeb, :controller

  alias EbcWebapp.Publication
  alias EbcWebapp.Publication.Post
  alias EbcWebapp.Twinder
  alias EbcWebapp.Twinder.User

  def index(conn, _params) do
    posts = Publication.list_posts()
    user = Twinder.get_user! 1
    render(conn, "index.html", posts: posts, user: user)
  end

  def new(conn, _params) do
    changeset = Publication.change_post(%Post{})
    users = Twinder.list_users()
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, params) do
    IO.inspect params
    #case Publication.create_post(post_params) do
    #  {:ok, post} ->
    #    conn
    #    |> put_flash(:info, "Post created successfully.")
    #    |> redirect(to: Routes.post_path(conn, :show, post))

    #  {:error, %Ecto.Changeset{} = changeset} ->
    #    render(conn, "new.html", changeset: changeset)
    #end
  end

  def show(conn, %{"id" => id}) do
    post = Publication.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Publication.get_post!(id)
    changeset = Publication.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Publication.get_post!(id)

    case Publication.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Publication.get_post!(id)
    {:ok, _post} = Publication.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
