using Gee;
namespace LAIR{
	class DollClothes : Sprites{
		ArrayList<ImageResource> rDollClothes = new ArrayList<ImageResource>();
		public DollClothes(ArrayList<string> TilesData, ArrayList<string> SpritesData, ArrayList<string> DollClothesData){
			base(TilesData, SpritesData);
			foreach(string DollClotheData in DollClothesData){
				this.AddDollCloth(DollClotheData);
			}
		}
		public void AddDollCloth(string DollClothPath){
			rDollClothes.add(new ImageResource(DollClothPath));
		}
	}
}