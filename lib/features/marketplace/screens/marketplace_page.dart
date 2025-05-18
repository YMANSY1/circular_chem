import 'package:circular_chem_app/core/models/category_enum.dart';
import 'package:circular_chem_app/features/marketplace/widgets/marketplace_item_card.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/item.dart';
import '../models/seller.dart';
import '../widgets/category_list_view.dart';
import '../widgets/featured_seller_list_view.dart';
import '../widgets/icon_text.dart';

class MarketplacePage extends StatelessWidget {
  MarketplacePage({super.key});

  final categories = <Category>[
    Category(
      CategoryType.metalMaterials.name,
      'assets/images/metal_materials.jpg',
    ),
    Category(
      CategoryType.plasticComponents.name,
      'assets/images/plastic_components.jpg',
    ),
    Category(
      CategoryType.textilesFabrics.name,
      'assets/images/textiles_fabrics.jpg',
    ),
    Category(
      CategoryType.woodSawdust.name,
      'assets/images/wood_sawdust.jpg',
    ),
    Category(
      CategoryType.chemicalByproducts.name,
      'assets/images/chemical_byproducts.jpg',
    ),
    Category(
      CategoryType.rubberElastomers.name,
      'assets/images/rubber_elastomers.jpg',
    ),
  ];

  final featuredSellers = [
    Seller('Lafarge Egypt',
        'https://yt3.googleusercontent.com/ytc/AIdro_lXNYu5BUxlDaZgi-XTRzA8gXSYTK-tSIDiylg07jh_EvU=s900-c-k-c0x00ffffff-no-rj'),
    Seller('Elsewedy Electric',
        'https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/062012/el_swedy_electric.png?itok=aFE8M_UV'),
    Seller('Jotun Egypt',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwehX4-PTLEjf0SciBLKu648_hBHb_sbmduw&s'),
    Seller('Arabian Cement Co.',
        'https://media.licdn.com/dms/image/v2/C4D0BAQFc3NNYWL9RHw/company-logo_200_200/company-logo_200_200/0/1630549190444/arabian_cement_company_logo?e=2147483647&v=beta&t=BTF7i10erfGLixEI_e_jMokeJ39zW-crIe9h7zhSkE4'),
    Seller('Suez Steel',
        'https://www.solbmisr.com/Content/assets/images/home/suez-steel-logo.jpg'),
    Seller('Ezz Steel',
        'https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/062024/ezz_steel.jpg?PflEveY5lcoFBRI2QZ263QSujWgwc2yg&itok=k5UOeToN'),
    Seller(
      'Misr El Hegaz',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRistjOOcyCVG77v5-OxDMJ6dtmUDu6eIZzdA&s',
    ),
    Seller('Oriental Weavers',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEtjSGKkHD9J0pxggKQyuRTE2jk2zm2zmK2A&s'),
  ];

  List<Item> get items => [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: IconText(
              text: 'Categories',
              icon: Icons.category_sharp,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: CategoryListView(categories: categories),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: IconText(
                text: 'Featured Sellers',
                icon: Icons.factory,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FeaturedSellerListView(featuredSellers: featuredSellers),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: IconText(
                text: 'Have a Browse!',
                icon: Icons.shopping_basket_rounded,
              ),
            ),
          ),
          SliverList.separated(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return MarketplaceItemCard(item: items[index]);
            },
            separatorBuilder: (_, __) => SizedBox(height: 8),
          )
        ],
      ),
    );
  }
}
