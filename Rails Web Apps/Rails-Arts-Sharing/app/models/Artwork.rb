class Artwork < ApplicationRecord

    validates :title, :image_url, :artist_id, presence: true
    validates :title, uniqueness: {scope: :artist_id, case_sensitive: false}

    belongs_to(
        :artist,
        class_name: 'User',
        foreign_key: :artist_id,
        primary_key: :id
    )

    has_many(
        :artwork_shares,
        class_name: 'ArtworkShare',
        foreign_key: :artwork_id,
        primary_key: :id,
        dependent: :destroy
    )
    
    has_many(
        :comments,
        class_name: 'Comment',
        foreign_key: :artwork_id,
        primary_key: :id,
        dependent: :destroy
    )
    
    has_many :art_viewers, through: :artwork_shares, source: :viewer
end