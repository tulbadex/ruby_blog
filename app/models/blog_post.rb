class BlogPost < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true

    scope :sorted, -> { order(published_at: :desc, created_at: :desc)}
    scope :draft, -> { where(published_at: nil)}
    scope :published, -> { where("published_at <= ?", Time.current) }
    scope :scheduled, -> { where("published_at > ?", Time.current) }
    # Ex:- scope :active, -> {where(:active => true)}

    def draft?
        published_at.nil?
    end

    def published?
        published_at? && published_at <= Time.current
    end

    def scheduled?
        published_at? && published_at > Time.current
    end
end
