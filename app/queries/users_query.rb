class UsersQuery

  def initialize(scope: User.all)
    @scope = scope
  end

  def call(params)
    @params = params
    @scope
      .yield_self(&method(:filter_by_email))
  end

  private

  def filter_by_email(current_scope, value = @params[:email])
    value ? current_scope.by_email(value) : current_scope
  end
end