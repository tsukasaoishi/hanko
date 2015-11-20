require 'digest/md5'
require 'digest/rmd160'
require 'digest/sha1'
require 'digest/sha2'

module ExpectSet
  FINGERPRINT = {
    Digest::MD5 => {
      image: "2f497bd6dad322e0bc97bba88145d20f",
      js: "2826170091b66c8d721c63e5f1a6016b",
      css: "70c0d1c707e70001082e7a85795cf146"
    },

    Digest::RMD160 => {
      image: "360e72d93b500a1b4351d7ad54b96a177cc9a8bb",
      js: "ee0244b55cecf3a43c0283e416a165ae4501af74",
      css: "86056fa784c76c4ce553848feb18077758b3a7eb"
    },

    Digest::SHA1 => {
      image: "d478abba18738d5cbc85a761041d51ef67dcb3ce",
      js: "475c437ef3a1376cca09c1f2f3f18b3673b837ee",
      css: "c80b6560ae9882c03ee1743dd16e694a63f6e97f"
    },

    Digest::SHA256 => {
      image: "ec0460828247a87f4a8f78a28a3b0545546833f0b3bd186f5352bb8bb8c673ca",
      js: "035354580de79c3d4a7968c974df2ae76befa53dc1f3597507db0427dea4d09e",
      css: "5b59e7f86cc54cd79e0d6c12af4d053eaef6cc0be92598e5be335f83e036be14"
    },

    Digest::SHA384 => {
      image: "f789f9f40bd95f28d363ba00dd216928d61e47e3f3d68b17d811558baad626471fc5e715df9b5e006e710d00cbe1a4f4",
      js: "79691cb2899bbe900c60f81c5415c045d17090012f94a0d5cc42dc3892966e2d758a6d230c7413d7200dea18812c32db",
      css: "34c9ea3fee728489e0e878714305765234173792c76e6e8bb81edff9be06426e8630f1d951474ca25c91c8165fa5ef4c"
    },

    Digest::SHA512 => {
      image: "86a354c9012d7f02cee9263ff6c4d4585e899d51abbcd6f9070ae58a397b019c3503d7af89032d767e330d8c802538fc5619f3bc3b458b433d7e1cff12d3e4ab",
      js: "7412ce0dc6630d4f2b5ef36669e53ddc5fc732b76916717c94a5c42b78eebde54cc4d90d73b1b39806d717ec333596a52a550ea05dbc8cb4601e4c592bc4d935",
      css: "815ff6bd4847b43102d4f60c351f34ff3e64be6fbe430970c9a385ec3035cb9ebd834733a2980c95f0dfca91fe9bdef82b97605447c0861fbb806f5d5971b4d7"
    }
  }

  def each_digests(type: nil)
    FINGERPRINT.each do |digest_class, fingerprint|
      Hanko::Fingerprint.digest_class = digest_class
      yield(digest_class, fingerprint[type])
    end
  end
end
