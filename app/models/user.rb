
class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :authored_polls,
        foreign_key: :author_id,
        primary_key: :id,
        class_name: 'Poll'

    has_many :responses,
        foreign_key: :respondent_id,
        primary_key: :id,
        class_name: 'Response'

    def completed_polls
        data = Poll.find_by_sql(<<-SQL)
            SELECT 
                polls.*
            FROM
                polls
            JOIN
                questions ON questions.poll_id = polls.id
            JOIN
                answer_choices ON answer_choices.question_id = questions.id
            LEFT OUTER JOIN (
                SELECT
                    *
                FROM
                    responses
                WHERE
                    responses.respondent_id = #{self.id}
            ) AS responses ON answer_choices.id = responses.answer_choice_id
            GROUP BY 
                polls.id
            HAVING
                COUNT(DISTINCT questions.id) = COUNT(responses.id)
        SQL
        data
    end

end