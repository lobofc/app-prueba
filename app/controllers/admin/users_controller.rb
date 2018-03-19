module Admin
  # UsersController
  class UsersController < AdminController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]

    def index
      @q = User.ransack(params[:q])
      users = @q.result(distinct: true).where('id != ?', current_user.id)
      @objects = users.page(@current_page)
      @total = users.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to users_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    def new
      @user = User.new
    end

    def show
      if @user.id.eql?(1)
        redirect_to admin_users_path, notice: "El usuario Admin, no puede ser editado"
      end
    end

    def edit
    end

    def update
      update_attributes = user_params.delete_if do |_, value|
        value.blank?
      end

      if @user.id.eql?(1)
        redirect_to admin_users_path, notice: "El usuario Admin, no puede ser editado"
      elsif @user.update_attributes(update_attributes)
        redirect(@user, params)
      else
        render action: 'edit'
      end
    end

    def create
      @user = User.new(user_params)

      if @user.save
        @user.add_role Role.find(user_params.fetch(:role_ids)).name
        redirect(@user, params)
      else
        render action: 'new'
      end
    end

    def destroy
      if @user.destroy.nil?
        redirect_to admin_users_path, notice: "El usuario Admin, no puede ser borrado"
      else
        redirect_to admin_users_path, notice: actions_messages(@user)
      end
    end

    def destroy_multiple
      if params[:multiple_ids][1].eql?('1')
        User.destroy redefine_ids(params[:multiple_ids])
        redirect_to(
          admin_users_path(page: @current_page, search: @query),
          notice: "El usuario Admin, no puede ser borrado"
        )
      else
        User.destroy redefine_ids(params[:multiple_ids])
        redirect_to(
          admin_users_path(page: @current_page, search: @query),
          notice: actions_messages(User.new)
        )
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :name, :email, :password, :password_confirmation,
        :role_ids, :encrypted_password
      )
    end

    def show_history
      get_history(User)
    end

    # Get submit key to redirect, only [:create, :update]
    def redirect(object, commit)
      if commit.key?('_save')
        redirect_to admin_user_path(object), notice: actions_messages(object)
      elsif commit.key?('_add_other')
        redirect_to new_admin_user_path, notice: actions_messages(object)
      elsif commit.key?('_assing_rol')
        redirect_to admin_users_path, notice: actions_messages(object)
      end
    end
  end
end
