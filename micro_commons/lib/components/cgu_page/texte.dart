import 'package:flutter/material.dart';
import 'package:micro_commons/components/cgu_page/cgu_texte.dart';

class Texte extends StatelessWidget {
  const Texte({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CguBodyWidget(
          text:
          "L’utilisation de la page WEB Mytouchpoint.net et des services mis à disposition des Clients est soumise au respect des présentes Conditions Générales d'Utilisation."),
      CguTitleWidget(
          title: "1. Définitions"),
      CguBodyWidget(
          text:
          '''Conditions Générales d'Utilisation: désigne l'ensemble des dispositions prévues que vous avez acceptées dans le cadre de l'utilisation du site.'''
              '''Contenu: désigne l’ensemble des éléments audiovisuels, cinématographiques, textuels, littéraires, sonores, graphiques, typographiques et photographiques, des logiciels, des bases de données, des applications, des images animés, des jeux multimédia, etc. disponibles sur le Site Mytouchpoint.net.'''
              '''Service: désigne(nt) la solution de paiement d’INTOUCH et les services des Partenaires proposés au Clients sur le site Mytouchpoint.net.'''
              '''Territoire : désigne la France.'''
              '''Client : désigne toute personne physique ayant rempli les conditions d’accès aux Services aux fins d’accéder aux Contenus sur le Site Mytouchpoint.net.'''),
      CguTitleWidget(title: "2. Objet"),
      CguBodyWidget(
          text:
          "Les présentes Conditions Générales d’Utilisation ont pour objet de définir les relations contractuelles entre le Client et INTOUCH concernant l’accès et l’utilisation du site Mytouchpoint.net et des Services."),
      CguTitleWidget(
          title: "3. Réclamations"),
      CguBodyWidget(
          text:
          "Les réclamations ou requêtes relatives à l’utilisation du site et aux produits et Services qui lui sont associés, les Clients pourront directement prendre contact avec le service client aux numéros suivants : via le formulaire en ligne ou notre standard par téléphonique au + 221 33 860 6444"),
      CguTitleWidget(
          title:
          "4. Protection des données personnelles"),
      CguBodyWidget(
          text:
          '''Lors de l'utilisation des Services, le Client pourra être amené à fournir à INTOUCH des données à caractère personnel en vue de l’utilisation du site et des Services (notamment et sans que cette liste soit limitative votre nom, votre prénom, votre adresse électronique, vos données de navigation). Le traitement de ces données est nécessaire à l’exécution des Services fournis par INTOUCH.'''
              '''Le traitement de ces données est nécessaire à l’exécution des présentes conditions générales d’utilisation et est réalisé conformément à la réglementation applicable à la protection des données personnelles.'''
              '''Ces données sont destinées au personnel de INTOUCH et à ses sous-traitants assurant la fourniture du site Mytouchpoint.net et, le cas échéant, à ses partenaires en conformité avec la réglementation applicable à la protection des données personnelles. Certaines données pourront également être accessibles à des organismes publics, auxiliaires de justice, officiers ministériels, afin de se conformer à toute loi ou réglementation en vigueur, à qui INTOUCH serait tenue de répondre (demande judiciaire ou administrative).'''
              '''Les données personnelles, ainsi que les informations relatives aux usages des Clients font l’objet d’un archivage électronique par INTOUCH pendant toute la durée de souscription aux Services et pendant la durée légale de conservation et de prescription.'''),
      CguBodyWidget(
          text:
          "Conformément à la règlementation applicable, le Client dispose à tout moment de différents droits relatifs aux données qui vous concernent (accès, rectification, suppression, opposition). Le Client doit effectuer sa demande en écrivant à INTOUCH et en l’accompagnant d’un justificatif d’identité. Le Client est responsable de l’exercice des droits précités et est réputé les avoir exercés en son nom."),
      CguBodyWidget(
          text:
          "Utilisation des données personnelles: TOUCH utilisera vos données de manière proportionnelle pour les fins énoncées dans les déclarations susvisées et tout en respectant les exigences légales en vigueur en matière d’authentification et d’identification."),
      CguBodyWidget(
          text:
          '''Droit d’accès, d’opposition, de rectification et de suppression sur la protection des données à caractère personnel, vous disposez d’un droit d’accès, de modification, de rectification et de suppression des données qui vous concernent.Pour exercer ces droits, il faut justifier de votre identité et prendre contact :'''
              '''- Par courriel : contact@intouchgroup.net'''
              '''- Par téléphone : + 221 33 860 6444.'''),
      CguTitleWidget(
          title:
          "5. Conditions générales d’utilisation des Services des Partenaires d’INTOUCH"),
      CguBodyWidget(
          text:
          '''L’utilisation des Services Partenaires proposés sur la plateforme de INTOUCH est soumise aux conditions générales des partenaires. Pour avoir accès à ces conditions générales, merci de vous rendre sur les sites des partenaires concernés.'''
              '''INTOUCH n’assume pas de responsabilité pour les dommages ou les pertes causés par l’utilisation par le Client des Services Partenaires et résultant de tout dysfonctionnement ou erreur émanant des systèmes Partenaires.'''),
      CguTitleWidget(
          title: "6. DISPONIBILITE DES SERVICES"),
      CguBodyWidget(
          text:
          '''L'utilisation des Services nécessite de disposer d'une connexion Internet et du matériel informatique adéquat dont l'ensemble des coûts, frais, abonnements et taxes sont indépendants des Services proposés par INTOUCH et à la charge exclusive du Client.'''
              '''Le Client s’engage à ne pas entraver le fonctionnement du site et des Services de quelque manière que ce soit et notamment à ne pas utiliser de programme informatique ayant pour but d’atteindre ou de rendre indisponible le Site et les Services et plus largement le système d’information de INTOUCH.'''
              '''Par ailleurs, chaque Client déclare connaître parfaitement les caractéristiques et les contraintes de l'Internet, et notamment le fait que les transmissions de données et d'informations sur l'Internet ne bénéficient que d'une fiabilité technique relative, celles-ci circulant sur des réseaux hétérogènes aux caractéristiques et capacités techniques diverses, qui peuvent perturber l'accès ou le rendre impossibles à certaines périodes.'''),
      CguTitleWidget(
          title: "7. RESPONSABILITE"),
      CguBodyWidget(
          text:
          "INTOUCH décline toute responsabilité en cas d'utilisation des Services non conforme aux présentes Conditions Générales d’Utilisation et dégage toute responsabilité pour toute inexécution de ses obligations résultant des Conditions Générales d'Utilisation qui relèvent d’un cas de force majeure."),
      CguTitleWidget(
          title: "8. PROPRIETE INTELLECTUELLE"),
      CguBodyWidget(
          text:
          '''Le Client reconnaît que le contrat ne lui concède aucun droit ni aucun titre de propriété quel qu’il soit sur le site Mytouchpoint.net et ne tentera aucune action qui mettrait en péril les droits d’INTOUCH. Le Client n’est pas autorisé à utiliser les marques et logos d’INTOUCH ou des groupes de sociétés auxquels celle-ci appartient sans l’accord préalable exprès de celle-ci.'''
              '''Aucune disposition des présentes Conditions Générales d’Utilisation ne confère ou ne sera considérée comme conférant au Client le droit ou la licence pour l’utilisation de sa propriété intellectuelle.'''),
      CguTitleWidget(
          title: "9. SUSPENSION- RESILIATION"),
      CguBodyWidget(
          text:
          "INTOUCH se réserve le droit d’interrompre de façon temporaire tout ou partie du Site ou des Services pour des raisons liées à la sécurité du Site. INTOUCH se réserve également le droit de mettre unilatéralement fin à la relation résultant des Conditions Générales d’Utilisation au cas où le Client ferait preuve de manquements significatifs à l’article 6 des présentes CGU."),

    ],);
  }
}
