import 'package:circular_chem_app/core/models/category_enum.dart';
import 'package:circular_chem_app/features/marketplace/widgets/marketplace_item_card.dart';
import 'package:flutter/material.dart';

import '../../marketplace/models/category.dart';
import '../../marketplace/models/item.dart';
import '../../marketplace/models/seller.dart';
import '../widgets/account_settings_tile.dart';
import '../widgets/profile_picture.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String companyName = 'Lapboost Technologies Inc.';
    final String email = 'contact@lapboost.com';
    final String password = '••••••••'; // Masked

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

    List<Item> items = [
      Item(
        'Recycled Aluminum Sheets',
        featuredSellers[0], // Lafarge Egypt
        categories[0], // Metal Materials
        4.5,
        1200.0,
      ),
      Item(
        'Plastic Resin Pellets',
        featuredSellers[6], // Misr El Hegaz
        categories[1], // Plastic Components
        4.2,
        850.0,
      ),
      Item(
        'Cotton Waste Rolls',
        featuredSellers[7], // Oriental Weavers
        categories[2], // Textiles & Fabrics
        4.7,
        600.0,
      ),
      Item(
        'Wood Dust Briquettes',
        featuredSellers[4], // Suez Steel
        categories[3], // Wood & Sawdust
        4.0,
        400.0,
      ),
      Item(
        'Used Rubber Mats',
        featuredSellers[5], // Ezz Steel
        categories[5], // Rubber & Elastomers
        3.9,
        320.0,
      ),
      Item(
        'PVC Scrap Bundles',
        featuredSellers[2], // Jotun Egypt
        categories[1], // Plastic Components
        4.4,
        910.0,
      ),
      Item(
        'Faded Denim Offcuts',
        featuredSellers[3], // Arabian Cement Co.
        categories[2], // Textiles & Fabrics
        4.6,
        700.0,
      ),
      Item(
        'Rubber Crumb Bags',
        featuredSellers[1], // Elsewedy Electric
        categories[5], // Rubber & Elastomers
        4.3,
        290.0,
      ),
      Item(
        'Reclaimed Wood Panels',
        featuredSellers[0], // Lafarge Egypt
        categories[3], // Wood & Sawdust
        4.1,
        1100.0,
      ),
      Item(
        'Industrial Solvent Waste',
        featuredSellers[1], // Elsewedy Electric
        categories[4], // Chemical Byproducts
        3.8,
        500.0,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Account Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ProfilePicture(),
          const SizedBox(height: 20),
          Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                AccountSettingsTile(
                  icon: Icons.business,
                  label: 'Company Name',
                  data: companyName,
                  iconColor: Colors.blue,
                  showEdit: true,
                ),
                const Divider(height: 1),
                AccountSettingsTile(
                  icon: Icons.assignment,
                  label: 'Tax Registration Number',
                  data: '000000000',
                  iconColor: Colors.deepPurpleAccent,
                  showEdit: false,
                ),
                const Divider(height: 1),
                AccountSettingsTile(
                  icon: Icons.email,
                  label: 'Email',
                  data: email,
                  iconColor: Colors.green,
                  showEdit: false,
                ),
                const Divider(height: 1),
                AccountSettingsTile(
                  icon: Icons.lock,
                  label: 'Password',
                  data: password,
                  iconColor: Colors.orange,
                  showEdit: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.trending_up, // Use the upward arrow icon
                  color: Colors.yellow,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Echo Points',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.yellow),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 8,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: () {},
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Add Item For Sale!',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) =>
                  MarketplaceItemCard(item: items[index]),
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 8),
            ),
          )
        ],
      ),
    );
  }
}
