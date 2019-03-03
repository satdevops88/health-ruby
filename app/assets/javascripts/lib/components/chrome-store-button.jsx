const ChromeStoreButton = ({ children, className }) => (
  <div className={className}>
    <a href="https://chrome.google.com/webstore/detail/adnpocldcgdpkddnfldmoejfbijjlmbm" target="_blank">
      <img
        alt="Available in the Chrome web store"
        src="https://res.cloudinary.com/healthiest/image/upload/v1516491737/ChromeWebStore_BadgeWBorder_v2_340x96_avuxmt.png"
        width={170} />
      {children}
    </a>
  </div>
)

export default ChromeStoreButton