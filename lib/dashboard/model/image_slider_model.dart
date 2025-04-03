class ImageSliderModel {
  String? sliderid;
  String? sliderUrl;
  String? formUrl;
  String? schemeName;
  String? status;
  String? sliderPath;
  String? promotionPopup;

  ImageSliderModel(
      {this.sliderid, this.sliderUrl, this.formUrl, this.schemeName, 
      this.status, 
      this.sliderPath
      });

  ImageSliderModel.fromJson(Map<String, dynamic> json) {
    sliderid = json['sliderid'];
    sliderUrl = json['sliderUrl'];
    formUrl = json['FormUrl'];
    schemeName = json['SchemeName'];
    status = json['StatusId'];
    sliderPath = json['SliderPath'];
    promotionPopup = json['PromotionPopup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sliderid'] = sliderid;
    data['sliderUrl'] = sliderUrl;
    data['FormUrl'] = formUrl;
    data['SchemeName'] = schemeName;
    data['StatusId'] = status;
    data['SliderPath'] = sliderPath;
    data['PromotionPopup'] = promotionPopup;
    return data;
  }
}
