import 'package:stayfinder_vendor/data/model/current_tier.dart';
import 'package:stayfinder_vendor/data/model/tier_model.dart';

List<Tier> teirData = [
  Tier(
      id: 1,
      name: "Free Tier",
      description: "Add one accomodation for a month",
      image:
          "https://res.cloudinary.com/dkh9ktvzu/image/upload/v1697608461/Flying_bird-rafiki_1_2_ks3jxq.png",
      price: "0",
      accomodationLimit: 1,
      isCurrent: true),
  Tier(
      id: 2,
      name: "Novice Tier",
      description: "Add one accomodation as you pay",
      image:
          "https://res.cloudinary.com/dkh9ktvzu/image/upload/v1697608461/Flying_bird-bro_2_f6cixb.png",
      price: "1000",
      accomodationLimit: 1,
      isCurrent: false),
  Tier(
      id: 3,
      name: "Ultra Tier",
      description: "Add two accomodation for a month",
      image:
          "https://res.cloudinary.com/dkh9ktvzu/image/upload/v1697608461/Flying_bird-pana_1_2_tn9jax.png",
      price: "2000",
      accomodationLimit: 2,
      isCurrent: false),
  Tier(
      id: 4,
      name: "Premium Tier",
      accomodationLimit: 3,
      description: "Add three accomodation for a month",
      image:
          "https://res.cloudinary.com/dkh9ktvzu/image/upload/v1697608461/Flying_phoenix-amico_1_2_zka49m.png",
      price: "3000",
      isCurrent: false),
];

// List<CurrentTier> currentTierList = [
//   CurrentTier(id: 1, tier_id: teirData[0], paid: false, added_accomodations: 1)
// ];

CurrentTier tier = CurrentTier(
    id: 1, tier_id: teirData[0], paid: false, added_accomodations: 1);
