class ProfilModal {
  final int id;
  final String uuid;
  final String name;
  final String phone_number;
  final String email;
  final String photo_path;
  final String facebook;
  final String instagram;
  final String created_at;
  final String updated_at;

  ProfilModal(
      this.id,
      this.uuid,
      this.name,
      this.phone_number,
      this.email,
      this.photo_path,
      this.facebook,
      this.instagram,
      this.created_at,
      this.updated_at);
}

class GalleryModal {
  final int id;
  final String uuid;
  final String name;
  final String is_url;
  final String url;
  final String path;
  final String mime_type;
  final String status;
  final String created_at;
  final String updated_at;

  GalleryModal(this.id, this.uuid, this.name, this.is_url, this.url, this.path,
      this.mime_type, this.status, this.created_at, this.updated_at);
}

class SlideModal {
  final int id;
  final String uuid;
  final String gallery_uuid;
  final String admin_uuid;
  final String title;
  final int status;
  final String created_at;
  final String updated_at;
  final String path;

  SlideModal(this.id, this.uuid, this.gallery_uuid, this.admin_uuid, this.title,
      this.status, this.created_at, this.updated_at, this.path);
}

class ImageModal {
  final String image_path;

  ImageModal(this.image_path);
}

class CommunityModal {
  final int id;
  final String uuid;
  final String community_category_uuid;
  final String name;
  final String logo_path;
  final String address;
  final String city;
  final String province;
  final String description;
  final String image_path;
  final String location;
  final String facebook;
  final String instagram;
  final String youtube;
  final int status;
  final String created_at;
  final String updated_at;
  final String path;

  CommunityModal(
      this.id,
      this.uuid,
      this.community_category_uuid,
      this.name,
      this.logo_path,
      this.address,
      this.city,
      this.province,
      this.description,
      this.image_path,
      this.location,
      this.facebook,
      this.instagram,
      this.youtube,
      this.status,
      this.created_at,
      this.updated_at,
      this.path);
}

class TourModal {
  final int id;
  final String uuid;
  final String name;
  final String address;
  final String city;
  final String province;
  final String description;
  final String image_path;
  final String location;
  final String facebook;
  final String instagram;
  final String youtube;
  final int status;
  final String created_at;
  final String updated_at;

  TourModal(
      this.id,
      this.uuid,
      this.name,
      this.address,
      this.city,
      this.province,
      this.description,
      this.image_path,
      this.location,
      this.facebook,
      this.instagram,
      this.youtube,
      this.status,
      this.created_at,
      this.updated_at);
}

class BusinessModal {
  final int id;
  final String uuid;
  final String business_category_uuid;
  final String name;
  final String address;
  final String city;
  final String province;
  final String description;
  final String image_path;
  final String location;
  final String facebook;
  final String instagram;
  final String youtube;
  final String whatsapp;
  final String qr_code;
  final String category;
  final int status;
  final String created_at;
  final String updated_at;

  BusinessModal(
      this.id,
      this.uuid,
      this.business_category_uuid,
      this.name,
      this.address,
      this.city,
      this.province,
      this.description,
      this.image_path,
      this.location,
      this.facebook,
      this.instagram,
      this.youtube,
      this.whatsapp,
      this.qr_code,
      this.category,
      this.status,
      this.created_at,
      this.updated_at);
}

class FinancialModal {
  final int id;
  final String uuid;
  final String name;
  final String logo_path;
  final String address;
  final String city;
  final String province;
  final String description;
  final String image_path;
  final String location;
  final String facebook;
  final String instagram;
  final String youtube;
  final int status;
  final String created_at;
  final String updated_at;
  final String path;

  FinancialModal(
      this.id,
      this.uuid,
      this.name,
      this.logo_path,
      this.address,
      this.city,
      this.province,
      this.description,
      this.image_path,
      this.location,
      this.facebook,
      this.instagram,
      this.youtube,
      this.status,
      this.created_at,
      this.updated_at,
      this.path);
}

class NewsModal {
  final int id;
  final String uuid;
  final String title;
  final String content;
  final String image_path;
  final int status;
  final String created_at;
  final String updated_at;

  NewsModal(
    this.id,
    this.uuid,
    this.title,
    this.content,
    this.image_path,
    this.status,
    this.created_at,
    this.updated_at,
  );
}

class ReviewListModal {
  final int id;
  final String uuid;
  final String business_uuid;
  final String user_uuid;
  final String image_path;
  final String description;
  final double value;
  final int status;
  final String created_at;
  final String updated_at;
  final String name;
  final String photo_path;

  ReviewListModal(
      this.id,
      this.uuid,
      this.business_uuid,
      this.user_uuid,
      this.image_path,
      this.description,
      this.value,
      this.status,
      this.created_at,
      this.updated_at,
      this.name,
      this.photo_path);
}

class SlideAdminBank {
  final int id;
  final String uuid;
  final String name;
  final int is_url;
  final String url;
  final String path;
  final String mime_type;
  final int status;
  final String created_at;
  final String updated_at;

  SlideAdminBank(this.id, this.uuid, this.name, this.is_url, this.url,
      this.path, this.mime_type, this.status, this.created_at, this.updated_at);
}

class ListRegisterBank {
  final int id;
  final String uuid;
  final String financial_service_uuid;
  final String user_uuid;
  final String name;
  final String address;
  final String phone_number;
  final String email;
  final String profession;
  final String status;
  final String created_at;
  final String updated_at;
  final String pdf;

  ListRegisterBank(
      this.id,
      this.uuid,
      this.financial_service_uuid,
      this.user_uuid,
      this.name,
      this.address,
      this.phone_number,
      this.email,
      this.profession,
      this.status,
      this.created_at,
      this.updated_at,
      this.pdf);
}

class ListSubmissionBank {
  final int id;
  final String uuid;
  final String financial_service_uuid;
  final String user_uuid;
  final String name;
  final String address;
  final String business_name;
  final String business_address;
  final String income;
  final String loan_estimate;
  final String purpose;
  final String identity_card;
  final String created_at;
  final String updated_at;
  final String pdf;

  ListSubmissionBank(
      this.id,
      this.uuid,
      this.financial_service_uuid,
      this.user_uuid,
      this.name,
      this.address,
      this.business_name,
      this.business_address,
      this.income,
      this.loan_estimate,
      this.purpose,
      this.identity_card,
      this.created_at,
      this.updated_at,
      this.pdf);
}

class Youtube {
  final int id;
  final String uuid;
  final String name;
  final String url;
  final String url_thumbnail;
  final int status;
  final String created_at;
  final String updated_at;

  Youtube(
    this.id,
    this.uuid,
    this.name,
    this.url,
    this.url_thumbnail,
    this.status,
    this.created_at,
    this.updated_at,
  );
}
