class PublicController < ApplicationController

  def intro
    render layout: 'plain'
  end

  def video
    render layout: 'plain'
  end

  def facts
  end

  def what
  end

  # def framework
  # end

  def solutions
  end

  def culture
  end

  def policy
  end

  def team
    @team_members = TeamMember.order('position asc')
  end

  # def projects
  # end

end