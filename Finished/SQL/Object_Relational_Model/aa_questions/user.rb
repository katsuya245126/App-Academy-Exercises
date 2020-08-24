require_relative 'model_base.rb'

class User < ModelBase
  attr_accessor :id, :fname, :lname

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT *
        FROM users
       WHERE fname LIKE ? 
             AND lname LIKE ?
    SQL

    return nil if data.empty?

    User.new(data.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT CAST((COUNT(DISTINCT ql.id)) AS FLOAT) / COUNT(DISTINCT user_questions.id) AS average_karma
        FROM (SELECT *
                FROM questions AS q
               WHERE q.user_id = ?) AS user_questions
             JOIN question_likes AS ql
             ON user_questions.id = ql.question_id
    SQL

    data.first['average_karma']
  end
end
