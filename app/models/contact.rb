class Contact < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :qrcode, dependent: :destroy
  before_commit :generate_qrcode, on: [:create, :update]
  validates :name, presence: true, uniqueness: true


  private

  def generate_qrcode

    # Generate QR code
    # qrcode = RQRCode::QRCode.new(contact_url(self)) # http://localhost:3000/contacts/1
    qrcode = RQRCode::QRCode.new(contact_url(self.name.parameterize)) # http://localhost:3000/contacts/john-doe

    # Generate the PNG file
    png = qrcode.as_png(
      size: 200
    )

    # Save the PNG file to a blob
    self.qrcode.attach(
      io: StringIO.new(png.to_s),
      filename: "qrcode.png",
      content_type: "image/png"
    )
  end
end
