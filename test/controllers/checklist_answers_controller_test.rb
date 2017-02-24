require 'test_helper'

class ChecklistAnswersControllerTest < ActionController::TestCase
  setup do
    @checklist_answer = checklist_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checklist_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checklist_answer" do
    assert_difference('ChecklistAnswer.count') do
      post :create, checklist_answer: { checklist_id: @checklist_answer.checklist_id, title: @checklist_answer.title, user_id: @checklist_answer.user_id }
    end

    assert_redirected_to checklist_answer_path(assigns(:checklist_answer))
  end

  test "should show checklist_answer" do
    get :show, id: @checklist_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @checklist_answer
    assert_response :success
  end

  test "should update checklist_answer" do
    patch :update, id: @checklist_answer, checklist_answer: { checklist_id: @checklist_answer.checklist_id, title: @checklist_answer.title, user_id: @checklist_answer.user_id }
    assert_redirected_to checklist_answer_path(assigns(:checklist_answer))
  end

  test "should destroy checklist_answer" do
    assert_difference('ChecklistAnswer.count', -1) do
      delete :destroy, id: @checklist_answer
    end

    assert_redirected_to checklist_answers_path
  end
end
