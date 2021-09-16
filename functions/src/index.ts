import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {firestore} from "firebase-admin/lib/firestore";
import FieldValue = firestore.FieldValue;

admin.initializeApp();
const _db = admin.firestore();

export const onUpdateUser = functions
    .region("asia-northeast1")
    .firestore
    .document("users/{userId}")
    .onUpdate(async (change) => {
      const before = change.before.data();
      const after = change.after.data();

      // Likeしたら対象のトークのLike数を増やす+トークしたユーザーのLike数を増やす
      const beforeLike: Array<string> = before["likeTalkIds"];
      const afterLike: Array<string> = after["likeTalkIds"];
      const likeDiff = afterLike.filter((item) => beforeLike.indexOf(item) < 0);
      if (likeDiff.length > 0) {
        await addLikeToTalk(likeDiff[0]);
      }

      // フォローしたら対象のユーザーのフォロワー数を増やす
      const beforeFollow: Array<string> = before["followingUserIds"];
      const afterFollow: Array<string> = after["followingUserIds"];
      const followDiff = afterFollow.filter(
          (item) => beforeFollow.indexOf(item) < 0
      );
      if (followDiff.length > 0) {
        await addFollowerToUser(followDiff[0]);
      }
    });

const addLikeToTalk = async (talkId: string) => {
  await _db.collection("talks").doc(talkId).update({
    "likeNumber": FieldValue.increment(1),
  });
};

const addFollowerToUser = async (userId: string) => {
  await _db.collection("users").doc(userId).update({
    "followerNumber": FieldValue.increment(1),
  });
};

export const onUpdateTalk = functions
    .region("asia-northeast1")
    .firestore
    .document("talks/{talkId}")
    .onUpdate(async (change) => {
      const before = change.before.data();
      const after = change.after.data();

      // Like数が変わっていたら投稿者の合計Like数を計算する
      const beforeLikeNumber: number = before["likeNumber"];
      const afterLikeNumber: number = after["likeNumber"];
      if ((afterLikeNumber - beforeLikeNumber) > 0) {
      // 特に待つ必要はないのでawaitしない
        console.log("calctotallike");
        await updateTotalLikeToUser(after["createdUserId"]);
      }
    });

const updateTotalLikeToUser = async (userId: string) => {
  let totalLike = 0;
  (await _db.collection("talks")
      .where("createdUserId", "==", userId)
      .get()
  ).docs.forEach((doc) => {
    totalLike += doc.data()["likeNumber"];
  });
  await _db.collection("users").doc(userId).update({
    "likeNumber": totalLike,
  });
};
